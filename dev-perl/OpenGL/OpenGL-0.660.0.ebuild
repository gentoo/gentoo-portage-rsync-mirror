# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OpenGL/OpenGL-0.660.0.ebuild,v 1.4 2013/02/08 20:00:54 bicatali Exp $

EAPI=4

MODULE_AUTHOR="CHM"
MODULE_VERSION=0.66

inherit perl-module eutils

DESCRIPTION="Perl interface providing graphics display using OpenGL"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="media-libs/freeglut
	x11-libs/libICE
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXmu"
DEPEND="${RDEPEND}"

mydoc="Release_Notes"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.66-no-display.patch
}

src_compile() {
	sed -i -e 's/PERL_DL_NONLAZY=1//' Makefile || die
	perl-module_src_compile
}
