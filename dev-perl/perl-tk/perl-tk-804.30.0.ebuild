# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-tk/perl-tk-804.30.0.ebuild,v 1.2 2012/05/09 13:22:13 aballier Exp $

EAPI=4

MY_PN=Tk
MODULE_AUTHOR=SREZIC
MODULE_VERSION=804.030
inherit multilib perl-module

DESCRIPTION="A Perl Module for Tk"

LICENSE+=" BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND="x11-libs/libX11
	x11-libs/libXft
	media-libs/freetype
	>=media-libs/libpng-1.4
	virtual/jpeg"
RDEPEND="${DEPEND}"

# No test running here, requires an X server, and fails lots anyway.
SRC_TEST="skip"
PATCHES=( "${FILESDIR}"/xorg.patch )

src_prepare() {
	MAKEOPTS+=" -j1" #333049
	myconf=( X11ROOT=${EPREFIX}/usr XFT=1 -I${EPREFIX}/usr/include/ -l${EPREFIX}/usr/$(get_libdir) )
	mydoc="ToDo VERSIONS"

	perl-module_src_prepare
	# fix detection logic for Prefix, bug #385621
	sed -i -e "s:/usr:${EPREFIX}/usr:g" myConfig || die
	# having this around breaks with perl-module and a case-IN-sensitive fs
	rm build || die
}
