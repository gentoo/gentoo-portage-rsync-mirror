# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/neatx/neatx-0.3.1_p59-r1.ebuild,v 1.9 2012/12/18 13:58:43 voyageur Exp $

EAPI="3"

PYTHON_DEPEND="2"
inherit eutils autotools python multilib user

DESCRIPTION="Google implementation of NX server"
HOMEPAGE="http://code.google.com/p/neatx/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/docutils"
RDEPEND="dev-python/pexpect
	 dev-python/simplejson
	 >=dev-python/pygtk-2.14
	 >=dev-python/pygobject-2.14:2
	 app-portage/portage-utils
	 media-fonts/font-misc-misc
	 media-fonts/font-cursor-misc
	 || ( net-analyzer/gnu-netcat
		net-analyzer/netcat
		net-analyzer/netcat6 )
	 net-misc/nx"

S=${WORKDIR}/${PN}

pkg_setup () {
	# configure script looks for latest python2 only,
	# no multiple versions support
	python_set_active_version 2
	python_pkg_setup

	if [ -z "${NX_HOME_DIR}" ];
	then
		export NX_HOME_DIR=/var/lib/neatx/home
	fi
	enewuser nx -1 -1 ${NX_HOME_DIR}
}

src_prepare() {
	sed -i -e "s/rst2html]/rst2html.py]/" configure.ac \
		|| die "configure.ac sed failed"
	sed -e "s#/lib/neatx#/neatx#" \
		-e "/^docdir/s#\$(PACKAGE)#${PF}#" \
		-e "s#-Werror##" \
		-i Makefile.am \
		|| die "Makefile.am sed failed"
	sed	-e "/DATA_DIR =/s#/lib/neatx#/neatx#" \
		-i lib/constants.py || die "constants.py sed failed"

	eautoreconf

	echo "#!/bin/sh" > autotools/py-compile
}

src_compile() {
	default_src_compile
	# Scripts are automatically generated, fix them here
	python_convert_shebangs 2 src/nx*
}

src_install() {
	emake install DESTDIR="${D}" || die "Failed to install"
	fperms 777 /var/lib/neatx/sessions
	dodir ${NX_HOME_DIR}/.ssh
	fowners nx:nx ${NX_HOME_DIR}
	fowners nx:nx ${NX_HOME_DIR}/.ssh

	insinto /etc
	newins doc/neatx.conf.example neatx.conf

	# nc or netcat6 or netcat?
	if has_version net-analyzer/gnu-netcat; then
		nc_path="/usr/bin/netcat"
	elif has_version net-analyzer/netcat6; then
		nc_path="/usr/bin/nc6"
	else
		nc_path="/usr/bin/nc"
	fi
	cat >> "${D}"/etc/neatx.conf << EOF

netcat-path = ${nc_path}
use-xsession = false
start-gnome-command = /etc/X11/Sessions/Gnome
EOF

	insinto ${NX_HOME_DIR}/.ssh
	insopts -m 600 -o nx
	newins extras/authorized_keys.nomachine authorized_keys
}

pkg_postinst () {
	python_mod_optimize neatx

	# Other NX servers ebuilds may have already created the nx account
	# However they use different login shell/home directory paths
	if [[ ${ROOT} == "/" ]]; then
		usermod -s /usr/$(get_libdir)/neatx/nxserver-login nx || die "Unable to set login shell of nx user!!"
		usermod -d ${NX_HOME_DIR} nx || die "Unable to set home directory of nx user!!"
	else
		elog "If you had another NX server installed before, please make sure"
		elog "the nx user account is correctly set to:"
		elog " * login shell: /usr/$(get_libdir)/neatx/nxserver-login"
		elog " * home directory: ${NX_HOME_DIR}"
	fi

	if has_version net-misc/openssh[-pam]; then
		elog ""
		elog "net-misc/openssh was not built with PAM support"
		elog "You will need to unlock the nx account by setting a password for it"
	fi

	elog "If you want to use the default su authentication (rather than ssh)"
	elog "you must ensure that the nx user is a member of the wheel group."
	elog "You can add it via \"usermod -a -G wheel nx\""
}

pkg_postrm() {
	python_mod_cleanup neatx
}
