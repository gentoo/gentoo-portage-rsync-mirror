# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ufw/ufw-0.33-r2.ebuild,v 1.1 2012/12/06 09:00:53 thev00d00 Exp $

EAPI=4
PYTHON_DEPEND="2:2.6 3:3.1"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 *-jython"

inherit versionator bash-completion-r1 eutils linux-info distutils

MY_PV_12=$(get_version_component_range 1-2)
DESCRIPTION="A program used to manage a netfilter firewall"
HOMEPAGE="http://launchpad.net/ufw"
SRC_URI="http://launchpad.net/ufw/${MY_PV_12}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="sys-devel/gettext"
# ipv6 forced: bug 437266
RDEPEND=">=net-firewall/iptables-1.4[ipv6]
	!<kde-misc/kcm-ufw-0.4.2
	!<net-firewall/ufw-frontends-0.3.2
"

# tests fail; upstream bug: https://bugs.launchpad.net/ufw/+bug/815982
RESTRICT="test"

pkg_pretend() {
	local CONFIG_CHECK="~PROC_FS
		~NETFILTER_XT_MATCH_COMMENT ~NETFILTER_XT_MATCH_HL
		~NETFILTER_XT_MATCH_LIMIT ~NETFILTER_XT_MATCH_MULTIPORT
		~NETFILTER_XT_MATCH_RECENT ~NETFILTER_XT_MATCH_STATE"

	if kernel_is -ge 2 6 39; then
		CONFIG_CHECK+=" ~NETFILTER_XT_MATCH_ADDRTYPE"
	else
		CONFIG_CHECK+=" ~IP_NF_MATCH_ADDRTYPE"
	fi

	check_extra_config

	# Check for default, useful optional features.
	if ! linux_config_exists; then
		ewarn "Cannot determine configuration of your kernel."
		return
	fi

	if ! linux_chkconfig_present IPV6; then
		echo
		ewarn "This version of ufw requires that IPv6 is enabled."
		ewarn "If you don't want it, install ${CATEGORY}/${PN}-0.31.1."
		ewarn "More information can be found in bug 437266."
	fi

	local nf_nat_ftp_ok="yes"
	local nf_conntrack_ftp_ok="yes"
	local nf_conntrack_netbios_ns_ok="yes"

	linux_chkconfig_present \
		NF_NAT_FTP || nf_nat_ftp_ok="no"
	linux_chkconfig_present \
		NF_CONNTRACK_FTP || nf_conntrack_ftp_ok="no"
	linux_chkconfig_present \
		NF_CONNTRACK_NETBIOS_NS || nf_conntrack_netbios_ns_ok="no"

	# This is better than an essay for each unset option...
	if [[ ${nf_nat_ftp_ok} = no ]] || [[ ${nf_conntrack_ftp_ok} = no ]] \
		|| [[ ${nf_conntrack_netbios_ns_ok} = no ]]
	then
		echo
		local mod_msg="Kernel options listed below are not set. They are not"
		mod_msg+=" mandatory, but they are often useful."
		mod_msg+=" If you don't need some of them, please remove relevant"
		mod_msg+=" module name(s) from IPT_MODULES in"
		mod_msg+=" '${EROOT}etc/default/ufw' before (re)starting ufw."
		mod_msg+=" Otherwise ufw may fail to start!"
		ewarn "${mod_msg}"
		if [[ ${nf_nat_ftp_ok} = no ]]; then
			ewarn "NF_NAT_FTP: for better support for active mode FTP."
		fi
		if [[ ${nf_conntrack_ftp_ok} = no ]]; then
			ewarn "NF_CONNTRACK_FTP: for better support for active mode FTP."
		fi
		if [[ ${nf_conntrack_netbios_ns_ok} = no ]]; then
			ewarn "NF_CONNTRACK_NETBIOS_NS: for better Samba support."
		fi
	fi
}

src_prepare() {
	# Remove warning about 'state' being obsolete in iptables 1.4.16.2.
	epatch "${FILESDIR}"/${P}-conntrack.patch
	# Allow to remove unnecessary build time dependency
	# on net-firewall/iptables.
	epatch "${FILESDIR}"/${P}-dont-check-iptables.patch
	# Move files away from /lib/ufw.
	epatch "${FILESDIR}"/${PN}-0.31.1-move-path.patch
	# Contains fixes related to SUPPORT_PYTHON_ABIS="1" (see comment in the
	# file).
	epatch "${FILESDIR}"/${PN}-0.31.1-python-abis.patch

	# Set as enabled by default. User can enable or disable
	# the service by adding or removing it to/from a runlevel.
	sed -i 's/^ENABLED=no/ENABLED=yes/' conf/ufw.conf \
		|| die "sed failed (ufw.conf)"

	#sed -i "s/^IPV6=yes/IPV6=$(usex ipv6)/" conf/ufw.defaults || die

	# If LINGUAS is set install selected translations only.
	if [[ -n ${LINGUAS+set} ]]; then
		_EMPTY_LOCALE_LIST="yes"
		pushd locales/po > /dev/null || die

		local lang
		for lang in *.po; do
			if ! has "${lang%.po}" ${LINGUAS}; then
				rm "${lang}" || die
			else
				_EMPTY_LOCALE_LIST="no"
			fi
		done

		popd > /dev/null || die
	else
		_EMPTY_LOCALE_LIST="no"
	fi
}

src_install() {
	newconfd "${FILESDIR}"/ufw.confd ufw
	newinitd "${FILESDIR}"/ufw-2.initd ufw

	exeinto /usr/share/${PN}
	doexe tests/check-requirements

	# users normally would want it
	insinto /usr/share/doc/${PF}/logging/syslog-ng
	doins "${FILESDIR}"/syslog-ng/*

	insinto /usr/share/doc/${PF}/logging/rsyslog
	doins "${FILESDIR}"/rsyslog/*
	doins doc/rsyslog.example

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
	distutils_src_install
	[[ $_EMPTY_LOCALE_LIST != yes ]] && domo locales/mo/*.mo
	newbashcomp shell-completion/bash ${PN}
}

pkg_postinst() {
	distutils_pkg_postinst
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		echo
		elog "To enable ufw, add it to boot sequence and activate it:"
		elog "-- # rc-update add ufw boot"
		elog "-- # /etc/init.d/ufw start"
		echo
		elog "If you want to keep ufw logs in a separate file, take a look at"
		elog "/usr/share/doc/${PF}/logging."
	fi
	if [[ -z ${REPLACING_VERSIONS} ]] \
		|| [[ ${REPLACING_VERSIONS} < 0.33-r2 ]];
	then
		# etc-update etc. should show when the file needs updating
		# but let's inform about the change
		echo
		elog "Because of bug 437266 this version doesn't have ipv6 USE"
		elog "flag, so in case it's needed, please adjust 'IPV6' setting"
		elog "in /etc/default/ufw manually. (IPv6 is enabled there by default.)"
		# TODO: add message about check-requirements script when this
		# bug is fixed
	fi
	echo
	ewarn "Note: once enabled, ufw blocks also incoming SSH connections by"
	ewarn "default. See README, Remote Management section for more information."
}
