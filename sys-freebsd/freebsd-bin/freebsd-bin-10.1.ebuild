# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-bin/freebsd-bin-10.1.ebuild,v 1.1 2015/03/08 14:01:56 mgorny Exp $

EAPI=3

inherit bsdmk freebsd

DESCRIPTION="FreeBSD /bin tools"
SLOT="0"

IUSE=""

if [[ ${PV} != *9999* ]]; then
	KEYWORDS="~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
	SRC_URI="http://dev.gentoo.org/~mgorny/dist/freebsd/${RV}/${BIN}.tar.xz
			http://dev.gentoo.org/~mgorny/dist/freebsd/${RV}/${UBIN}.tar.xz
			http://dev.gentoo.org/~mgorny/dist/freebsd/${RV}/${SBIN}.tar.xz
			http://dev.gentoo.org/~mgorny/dist/freebsd/${RV}/${LIB}.tar.xz"
fi

RDEPEND="=sys-freebsd/freebsd-lib-${RV}*
	>=dev-libs/libedit-20120311.3.0-r1
	sys-libs/ncurses
	sys-apps/ed
	!app-misc/realpath
	!<sys-freebsd/freebsd-ubin-8"
DEPEND="${RDEPEND}
	=sys-freebsd/freebsd-mk-defs-${RV}*
	>=sys-devel/flex-2.5.31-r2"

S=${WORKDIR}/bin

# csh and tcsh are provided by tcsh package, rmail is sendmail stuff.
REMOVE_SUBDIRS="csh rmail ed freebsd-version"

pkg_setup() {
	mymakeopts="${mymakeopts} WITHOUT_TCSH= WITHOUT_SENDMAIL= WITHOUT_RCMDS= "
}
