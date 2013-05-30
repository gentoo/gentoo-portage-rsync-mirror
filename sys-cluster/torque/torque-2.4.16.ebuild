# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/torque/torque-2.4.16.ebuild,v 1.12 2013/05/30 01:12:56 jsbronder Exp $

EAPI=2
WANT_AUTOMAKE="1.12"
inherit flag-o-matic eutils linux-info autotools

DESCRIPTION="Resource manager and queuing system based on OpenPBS"
HOMEPAGE="http://www.adaptivecomputing.com/products/open-source/torque"
SRC_URI="http://www.adaptivecomputing.com/resources/downloads/${PN}/${P}.tar.gz"

LICENSE="openpbs"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="tk +crypt drmaa server +syslog doc cpusets kernel_linux"

# ed is used by makedepend-sh
DEPEND_COMMON="sys-libs/ncurses
	sys-libs/readline
	tk? ( dev-lang/tk )
	syslog? ( virtual/logger )
	!games-util/qstat"

DEPEND="${DEPEND_COMMON}
	doc? ( drmaa? (
		|| ( <app-doc/doxygen-1.7.6.1[latex,-nodot]	>=app-doc/doxygen-1.7.6.1[latex,dot] )
	) )
	sys-apps/ed"

RDEPEND="${DEPEND_COMMON}
	crypt? ( net-misc/openssh )
	!crypt? ( net-misc/netkit-rsh )"

pkg_setup() {
	PBS_SERVER_HOME="${PBS_SERVER_HOME:-/var/spool/torque}"

	# Find a Torque server to use.  Check environment, then
	# current setup (if any), and fall back on current hostname.
	if [ -z "${PBS_SERVER_NAME}" ]; then
		if [ -f "${ROOT}${PBS_SERVER_HOME}/server_name" ]; then
			PBS_SERVER_NAME="$(<${ROOT}${PBS_SERVER_HOME}/server_name)"
		else
			PBS_SERVER_NAME=$(hostname -f)
		fi
	fi

	USE_CPUSETS="--disable-cpuset"
	if use cpusets; then
		if ! use kernel_linux; then
			einfo
			elog "    Torque currently only has support for cpusets in linux."
			elog "Assuming you didn't really want this USE flag."
			einfo
		else
			linux-info_pkg_setup
			einfo
			elog "    Torque support for cpusets is still in development, you may"
			elog "wish to disable it for production use."
			einfo
			if ! linux_config_exists || ! linux_chkconfig_present CPUSETS; then
				einfo
				elog "    Torque support for cpusets will require that you recompile"
				elog "your kernel with CONFIG_CPUSETS enabled."
				einfo
			fi
			USE_CPUSETS="--enable-cpuset"
		fi
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/0002-fix-implicit-declaration-warnings.patch
	epatch "${FILESDIR}"/disable-automagic-doc-building-2.4.14.patch

	sed -i \
		-e 's,\(COMPACT_LATEX *=\).*,\1 NO,' \
		-e 's,\(GENERATE_MAN *=\).*,\1 NO,' \
		src/drmaa/Doxyfile.in || die
	sed -i \
		-e '/INSTALL_DATA/d' \
		src/drmaa/Makefile.am || die
	eautoreconf
}

src_configure() {
	local myconf="--with-rcp=mom_rcp"

	use crypt && myconf="--with-rcp=scp"

	if use drmaa && use doc; then
		myconf="${myconf} --enable-apidocs"
	else
		myconf="${myconf} --disable-apidocs"
	fi

	econf \
		$(use_enable tk gui) \
		$(use_enable syslog) \
		$(use_enable server) \
		$(use_enable drmaa) \
		--with-server-home=${PBS_SERVER_HOME} \
		--with-environ=/etc/pbs_environment \
		--with-default-server=${PBS_SERVER_NAME} \
		--disable-gcc-warnings \
		${USE_CPUSETS} \
		${myconf}
}

# WARNING
# OpenPBS is extremely stubborn about directory permissions. Sometimes it will
# just fall over with the error message, but in some spots it will just ignore
# you and fail strangely. Likewise it also barfs on our .keep files!
pbs_createspool() {
	local root="$1"
	local s="$(dirname "${PBS_SERVER_HOME}")"
	local h="${PBS_SERVER_HOME}"
	local sp="${h}/server_priv"
	einfo "Building spool directory under ${D}${h}"
	local a d m
	local dir_spec="
			0755:${h}/aux 0700:${h}/checkpoint
			0755:${h}/mom_logs 0751:${h}/mom_priv 0751:${h}/mom_priv/jobs
			1777:${h}/spool 1777:${h}/undelivered"

	if use server; then
		dir_spec="${dir_spec} 0755:${h}/sched_logs
			0755:${h}/sched_priv/accounting 0755:${h}/server_logs
			0750:${h}/server_priv 0755:${h}/server_priv/accounting
			0750:${h}/server_priv/acl_groups 0750:${h}/server_priv/acl_hosts
			0750:${h}/server_priv/acl_svr 0750:${h}/server_priv/acl_users
			0750:${h}/server_priv/jobs 0750:${h}/server_priv/queues"
	fi

	for a in ${dir_spec}; do
		d="${a/*:}"
		m="${a/:*}"
		if [[ ! -d "${root}${d}" ]]; then
			install -d -m${m} "${root}${d}"
		else
			chmod ${m} "${root}${d}"
		fi
		# (#149226) If we're running in src_*, then keepdir
		if [[ "${root}" = "${D}" ]]; then
			keepdir ${d}
		fi
	done
}

src_install() {
	# Make directories first
	pbs_createspool "${D}"

	emake DESTDIR="${D}" install || die "make install failed"

	dodoc CHANGELOG README.* Release_Notes || die "dodoc failed"
	if use doc; then
		dodoc doc/admin_guide.ps doc/*.pdf || die "dodoc failed"
		if use drmaa; then
			dohtml -r src/drmaa/doc/html/* || die
			dodoc src/drmaa/drmaa.pdf || die
		fi
	fi

	# The build script isn't alternative install location friendly,
	# So we have to fix some hard-coded paths in tclIndex for xpbs* to work
	for file in `find "${D}" -iname tclIndex`; do
		sed -e "s/${D//\// }/ /" "${file}" > "${file}.new" || die
		mv "${file}.new" "${file}" || die
	done

	if use server; then
		newinitd "${FILESDIR}"/pbs_server-init.d pbs_server
		newinitd "${FILESDIR}"/pbs_sched-init.d pbs_sched
	fi
	newinitd "${FILESDIR}"/pbs_mom-init.d pbs_mom
	newconfd "${FILESDIR}"/torque-conf.d torque
	newenvd "${FILESDIR}"/torque-env.d 25torque

	[ -d "${D}"/usr/share/doc/torque-drmaa ] && \
		rm -rf "${D}"/usr/share/doc/torque-drmaa
}

pkg_preinst() {
	if [[ -f "${ROOT}etc/pbs_environment" ]]; then
		cp "${ROOT}etc/pbs_environment" "${D}"/etc/pbs_environment
	fi

	echo "${PBS_SERVER_NAME}" > "${D}${PBS_SERVER_HOME}/server_name"

	# Fix up the env.d file to use our set server home.
	sed -i "s:/var/spool/torque:${PBS_SERVER_HOME}:g" \
		"${D}"/etc/env.d/25torque || die
}

pkg_postinst() {
	pbs_createspool "${ROOT}"
	elog "    If this is the first time torque has been installed, then you are not"
	elog "ready to start the server.  Please refer to the documentation located at:"
	elog "http://www.clusterresources.com/wiki/doku.php?id=torque:torque_wiki"

	elog "    For a basic setup, you may use emerge --config ${PN}"
}

# root will be setup as the primary operator/manager, the local machine
# will be added as a node and we'll create a simple queue, batch.
pkg_config() {
	local h="$(echo "${ROOT}/${PBS_SERVER_HOME}" | sed 's:///*:/:g')"
	local rc=0

	ebegin "Configuring Torque"
	einfo "Using ${h} as the pbs homedir"
	einfo "Using ${PBS_SERVER_NAME} as the pbs_server"

	# Check for previous configuration and bail if found.
	if [ -e "${h}/server_priv/acl_svr/operators" ] \
		|| [ -e "${h}/server_priv/nodes" ] \
		|| [ -e "${h}/mom_priv/config" ]; then
		ewarn "Previous Torque configuration detected.  Press any key to"
		ewarn "continue or press Control-C to abort now"
		read
	fi

	# pbs_mom configuration.
	echo "\$pbsserver ${PBS_SERVER_NAME}" > "${h}/mom_priv/config"
	echo "\$logevent 255" >> "${h}/mom_priv/config"

	if use server; then
		local qmgr="${ROOT}/usr/bin/qmgr -c"
		# pbs_server bails on repeated backslashes.
		if ! echo "y" | "${ROOT}"/usr/sbin/pbs_server -d "${h}" -t create; then
			eerror "Failed to start pbs_server"
			rc=1
		else
			${qmgr} "set server operators = root@$(hostname -f)" ${PBS_SERVER_NAME}
			${qmgr} "create queue batch" ${PBS_SERVER_NAME}
			${qmgr} "set queue batch queue_type = Execution" ${PBS_SERVER_NAME}
			${qmgr} "set queue batch started = True" ${PBS_SERVER_NAME}
			${qmgr} "set queue batch enabled = True" ${PBS_SERVER_NAME}
			${qmgr} "set server default_queue = batch" ${PBS_SERVER_NAME}
			${qmgr} "set server resources_default.nodes = 1" ${PBS_SERVER_NAME}
			${qmgr} "set server scheduling = True" ${PBS_SERVER_NAME}

			"${ROOT}"/usr/bin/qterm -t quick ${PBS_SERVER_NAME} || rc=1

			# Add the local machine as a node.
			echo "$(hostname -f) np=1" > "${h}/server_priv/nodes"
		fi
	fi
	eend ${rc}
}
