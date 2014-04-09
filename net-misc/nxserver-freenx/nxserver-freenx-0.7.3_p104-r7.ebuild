# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-freenx/nxserver-freenx-0.7.3_p104-r7.ebuild,v 1.1 2014/04/09 12:44:37 tomwij Exp $

EAPI="5"

inherit multilib eutils toolchain-funcs user versionator

MAJOR_PV="$(get_version_component_range 1-3)"
PATCH_VER="$(get_version_component_range 4)"
MY_PN="freenx-server"

DESCRIPTION="Free Software Implementation of the NX Server"
HOMEPAGE="http://freenx.berlios.de/ https://launchpad.net/~freenx-team"
SRC_URI="http://ppa.launchpad.net/freenx-team/ppa/ubuntu/pool/main/f/${MY_PN}/freenx-server_${MAJOR_PV}+teambzr${PATCH_VER/p}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+nxclient rdesktop vnc"

DEPEND="x11-misc/gccmakedep
	x11-misc/imake"

RDEPEND="dev-tcltk/expect
	media-fonts/font-cursor-misc
	media-fonts/font-misc-misc
	net-analyzer/gnu-netcat
	>=net-misc/nx-2.1.0
	x11-apps/xauth
	x11-apps/xrdb
	x11-apps/sessreg
	virtual/awk
	virtual/ssh
	nxclient? ( net-misc/nxclient )
	!nxclient? ( !net-misc/nxclient
				 || ( x11-misc/xdialog
					  x11-apps/xmessage ) )
	rdesktop? ( net-misc/rdesktop )
	vnc? ( x11-misc/x11vnc
		   net-misc/tightvnc )"

S=${WORKDIR}/${MY_PN}

export NX_HOME_DIR=/var/lib/nxserver/home

pkg_setup () {
	enewuser nx -1 -1 ${NX_HOME_DIR}
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-pam_ssh.patch
	epatch "${FILESDIR}"/${P}-nxnode_setup_samba.patch
	epatch "${FILESDIR}"/${P}-nxloadconfig.patch
	epatch "${FILESDIR}"/${PN}-0.7.2-cups.patch
	epatch "${FILESDIR}"/${P}-jobserver_fix.patch
	epatch "${FILESDIR}"/${P}-md5sum.patch

	# Path to net-misc/nx files, support for nx >= 3.4.0
	sed	-e "/PATH_LIB=/s/lib/$(get_libdir)/g" \
		-e "s#REAL_PATH_LIB#/usr/$(get_libdir)/NX/bin#" \
		-e "s#3.\[0123\].0#3.\[012345\].0#g" \
		-i nxloadconfig || die

	# Respect user's CC, CFLAGS and LDFLAGS and do other QA fixes.
	epatch "${FILESDIR}"/${P}-r7-QA-fixes.patch
}

src_compile() {
	emake CDEBUGFLAGS="${CFLAGS}" CC="$(tc-getCC)" EXTRA_LDOPTIONS="${LDFLAGS}"
}

src_install() {
	export NX_ETC_DIR=/etc/nxserver
	export NX_SESS_DIR=/var/lib/nxserver/db

	default

	# This should be renamed to remove the blocker on net-misc/nxclient
	if use nxclient ; then
		rm "${ED}"/usr/bin/nxprint || die
	fi

	mv "${ED}"/etc/nxserver/node.conf.sample "${ED}"/etc/nxserver/node.conf ||
		die "cannot find default configuration file"

	dodir ${NX_ETC_DIR}
	for x in passwords passwords.orig ; do
		touch "${ED}"/${NX_ETC_DIR}/$x
		fperms 600 ${NX_ETC_DIR}/$x
	done

	dodir ${NX_SESS_DIR}
	for x in closed running failed ; do
		keepdir ${NX_SESS_DIR}/$x
		fperms 0700 ${NX_SESS_DIR}/$x
	done

	dodir ${NX_HOME_DIR}

	newinitd "${FILESDIR}"/nxserver.init nxserver
}

pkg_postinst () {
	# Other NX servers ebuilds may have already created the nx account
	# However they use different login shell/home directory paths
	if [[ ${ROOT} == "/" ]]; then
		usermod -s /usr/bin/nxserver nx || die "Unable to set login shell of nx user!!"
		usermod -d ${NX_HOME_DIR} nx || die "Unable to set home directory of nx user!!"
		usermod -a -G utmp nx || die "Unable to add nx user to utmp group!!"
	else
		elog "If you had another NX server installed before, please make sure"
		elog "the nx user account is correctly set to:"
		elog " * login shell: /usr/bin/nxserver"
		elog " * home directory: ${NX_HOME_DIR}"
		elog " * supplementary groups: utmp"
	fi

	elog "To complete the installation, run:"
	elog " nxsetup --install --setup-nomachine-key"
	elog "This will use the default Nomachine SSH key"
	elog "If you had older NX servers installed, you may need to add \"--clean --purge\" to the nxsetup command"

	if has_version net-misc/openssh[-pam]; then
		elog ""
		elog "net-misc/openssh was not built with PAM support"
		elog "You will need to unlock the nx account by setting a password for it"
	fi
}
