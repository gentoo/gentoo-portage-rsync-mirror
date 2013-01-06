# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/complexity/complexity-1.0.ebuild,v 1.1 2012/11/26 13:12:21 jer Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="a tool designed for analyzing the complexity of C program
functions"
HOMEPAGE="http://www.gnu.org/software/complexity/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND="
	>=sys-devel/autogen-5.11.7
"
DEPEND="
	${RDEPEND}
	sys-devel/libtool
"

DOCS=( ChangeLog )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0-ac_aux_dir.patch
	eautoreconf
}
