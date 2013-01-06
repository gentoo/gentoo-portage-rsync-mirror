# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcp/dhcp-3.1.2_p1.ebuild,v 1.12 2012/12/09 21:16:16 ulm Exp $

inherit eutils flag-o-matic multilib toolchain-funcs

MY_PV="${PV//_alpha/a}"
MY_PV="${MY_PV//_beta/b}"
MY_PV="${MY_PV//_rc/rc}"
MY_PV="${MY_PV//_p/p}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="ISC Dynamic Host Configuration Protocol"
HOMEPAGE="http://www.isc.org/products/DHCP"
SRC_URI="ftp://ftp.isc.org/isc/dhcp/${MY_P}.tar.gz"

LICENSE="ISC BSD SSLeay GPL-2" # GPL-2 only for init script
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="doc minimal static selinux kernel_linux"

DEPEND="selinux? ( sec-policy/selinux-dhcp )
	kernel_linux? ( sys-apps/net-tools )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Gentoo patches - these will probably never be accepted upstream
	# Enable chroot support
	epatch "${FILESDIR}/${PN}"-3.0-paranoia.patch
	# Fix some permission issues
	epatch "${FILESDIR}/${PN}"-3.0-fix-perms.patch
	# Enable dhclient to equery NTP servers
	epatch "${FILESDIR}/${PN}"-3.0.3-dhclient-ntp.patch
	# resolvconf support in dhclient-script
	epatch "${FILESDIR}/${PN}"-3.1.0a1-dhclient-resolvconf.patch
	# Fix setting hostnames on Linux
	epatch "${FILESDIR}/${PN}"-3.0.3-dhclient-hostname.patch
	# Allow mtu settings
	epatch "${FILESDIR}/${PN}"-3.0.3-dhclient-mtu.patch
	# Allow dhclient to use IF_METRIC to set route metrics
	epatch "${FILESDIR}/${PN}"-3.0.3-dhclient-metric.patch
	# Stop downing the interface on Linux as that breaks link dameons
	# such as wpa_supplicant and netplug
	epatch "${FILESDIR}/${PN}"-3.0.3-dhclient-no-down.patch
	# Quiet the isc blurb
	epatch "${FILESDIR}/${PN}"-3.0.3-no_isc_blurb.patch
	# Enable dhclient to get extra configuration from stdin
	epatch "${FILESDIR}/${PN}"-3.0.4-dhclient-stdin-conf.patch
	# Disable fallback interfaces when using BPF
	# This allows more than one dhclient instance on the BSD's
	epatch "${FILESDIR}/${PN}"-3.0.5-bpf-nofallback.patch

	# General fixes which will probably be accepted upstream eventually
	# Install libdst, #75544
	epatch "${FILESDIR}/${PN}"-3.0.3-libdst.patch
	# Fix building on Gentoo/FreeBSD
	epatch "${FILESDIR}/${PN}"-3.0.2-gmake.patch

	# NetworkManager support patches
	# If they fail to apply to future versions they will be dropped
	# Add dbus support to dhclient
	epatch "${FILESDIR}/${PN}"-3.0.3-dhclient-dbus.patch

	# Denial of service through mixed identifier/ethernet host definitions
	epatch "${FILESDIR}/${P}"-CVE-2009-1892.patch

	# Brand the version with Gentoo
	# include revision if >0
	local newver="${MY_PV}-Gentoo"
	[[ ${PR} != "r0" ]] && newver="${newver}-${PR}"
	sed -i '/^#define DHCP_VERSION[ \t]\+/ s/'"${MY_PV}/${newver}/g" \
		includes/version.h || die

	# Change the hook script locations of the scripts
	sed -i -e 's,/etc/dhclient-exit-hooks,/etc/dhcp/dhclient-exit-hooks,g' \
		-e 's,/etc/dhclient-enter-hooks,/etc/dhcp/dhclient-enter-hooks,g' \
		client/scripts/* || die

	# No need for the linux script to force bash, #158540.
	sed -i -e 's,#!/bin/bash,#!/bin/sh,' client/scripts/linux || die

	# Quiet the freebsd logger a little
	sed -i -e '/LOGGER=/ s/-s -p user.notice //g' client/scripts/freebsd || die

	# Remove these options from the sample config
	sed -i -e "/\(script\|host-name\|domain-name\) / d" \
		client/dhclient.conf || die

	# Build sed man pages as we don't ever support BSD 4.4 and older, #130251.
	local x=
	for x in Makefile.dist $(ls */Makefile.dist) ; do
		sed -i -e 's/$(CATMANPAGES)/$(SEDMANPAGES)/g' "${x}" || die
	done

	# Only install different man pages if we don't have en
	if [[ " ${LINGUAS} " != *" en "* ]]; then
		# Install Japanese man pages
		if [[ " ${LINGUAS} " == *" ja "* && -d doc/ja_JP.eucJP ]]; then
			einfo "Installing Japanese documention"
			cp doc/ja_JP.eucJP/dhclient* client
			cp doc/ja_JP.eucJP/dhcp* common
		fi
	fi

	# Now remove the non-english docs so there are no errors later
	[[ -d doc/ja_JP.eucJP ]] && rm -rf doc/ja_JP.eucJP
}

src_compile() {
	use static && append-ldflags -static

	cat <<-END >> includes/site.h
	#define _PATH_DHCPD_CONF "/etc/dhcp/dhcpd.conf"
	#define _PATH_DHCPD_PID "/var/run/dhcp/dhcpd.pid"
	#define _PATH_DHCPD_DB "/var/lib/dhcp/dhcpd.leases"
	#define _PATH_DHCLIENT_CONF "/etc/dhcp/dhclient.conf"
	#define _PATH_DHCLIENT_DB "/var/lib/dhcp/dhclient.leases"
	#define _PATH_DHCLIENT_PID "/var/run/dhcp/dhclient.pid"
	#define DHCPD_LOG_FACILITY LOG_LOCAL1
	END

	cat <<-END > site.conf
	CC = $(tc-getCC)
	LFLAGS = ${LDFLAGS}
	LIBDIR = /usr/$(get_libdir)
	INCDIR = /usr/include
	ETC = /etc/dhcp
	VARDB = /var/lib/dhcp
	VARRUN = /var/run/dhcp
	ADMMANDIR = /usr/share/man/man8
	ADMMANEXT = .8
	FFMANDIR = /usr/share/man/man5
	FFMANEXT = .5
	LIBMANDIR = /usr/share/man/man3
	LIBMANEXT = .3
	USRMANDIR = /usr/share/man/man1
	USRMANEXT = .1
	MANCAT = man
	END

	./configure --copts "-DPARANOIA -DEARLY_CHROOT ${CFLAGS}" \
		|| die "configure failed"

	# Remove server support from the Makefile
	# We still install some extra crud though
	if use minimal ; then
		sed -i -e 's/\(server\|relay\|dhcpctl\)/ /g' work.*/Makefile || die
	fi
	emake || die "compile problem"
}

src_install() {
	make install DESTDIR="${D}" || die
	use doc && dodoc README RELNOTES doc/*

	insinto /etc/dhcp
	newins client/dhclient.conf dhclient.conf.sample
	keepdir /var/{lib,run}/dhcp
	keepdir /var/lib/dhclient

	# Install our server files
	if ! use minimal ; then
		insinto /etc/dhcp
		newins server/dhcpd.conf dhcpd.conf.sample
		newinitd "${FILESDIR}"/dhcpd.init2 dhcpd
		newinitd "${FILESDIR}"/dhcrelay.init dhcrelay
		newconfd "${FILESDIR}"/dhcpd.conf dhcpd
		newconfd "${FILESDIR}"/dhcrelay.conf dhcrelay

		# We never want portage to own this file
		rm -f "${D}"/var/lib/dhcp/dhcpd.leases
	fi
}

pkg_preinst() {
	if ! use minimal ; then
		enewgroup dhcp
		enewuser dhcp -1 -1 /var/lib/dhcp dhcp
	fi
}

pkg_postinst() {
	use minimal && return

	chown -R dhcp:dhcp "${ROOT}"/var/{lib,run}/dhcp

	if [[ -e "${ROOT}"/etc/init.d/dhcp ]] ; then
		ewarn
		ewarn "WARNING: The dhcp init script has been renamed to dhcpd"
		ewarn "/etc/init.d/dhcp and /etc/conf.d/dhcp need to be removed and"
		ewarn "and dhcp should be removed from the default runlevel"
		ewarn
	fi

	einfo "You can edit /etc/conf.d/dhcpd to customize dhcp settings."
	einfo
	einfo "If you would like to run dhcpd in a chroot, simply configure the"
	einfo "DHCPD_CHROOT directory in /etc/conf.d/dhcpd and then run:"
	einfo "  emerge --config =${PF}"
}

pkg_config() {
	if use minimal ; then
		eerror "${PN} has not been compiled for server support"
		eerror "emerge ${PN} without the minimal USE flag to use dhcp sever"
		return 1
	fi

	local CHROOT="$(
		sed -n -e 's/^[[:blank:]]\?DHCPD_CHROOT="*\([^#"]\+\)"*/\1/p' \
		"${ROOT}"/etc/conf.d/dhcpd
	)"

	if [[ -z ${CHROOT} ]]; then
		eerror "CHROOT not defined in /etc/conf.d/dhcpd"
		return 1
	fi

	CHROOT="${ROOT}/${CHROOT}"

	if [[ -d ${CHROOT} ]] ; then
		ewarn "${CHROOT} already exists - aborting"
		return 0
	fi

	ebegin "Setting up the chroot directory"
	mkdir -m 0755 -p "${CHROOT}/"{dev,etc,var/lib,var/run/dhcp}
	cp /etc/{localtime,resolv.conf} "${CHROOT}"/etc
	cp -R /etc/dhcp "${CHROOT}"/etc
	cp -R /var/lib/dhcp "${CHROOT}"/var/lib
	ln -s ../../var/lib/dhcp "${CHROOT}"/etc/dhcp/lib
	chown -R dhcp:dhcp "${CHROOT}"/var/{lib,run}/dhcp
	eend 0

	local logger="$(best_version virtual/logger)"
	einfo "To enable logging from the dhcpd server, configure your"
	einfo "logger (${logger}) to listen on ${CHROOT}/dev/log"
}
