# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autogen/autogen-5.17.3.ebuild,v 1.4 2013/05/04 05:26:51 vapier Exp $

EAPI="4"

inherit eutils autotools

DESCRIPTION="Program and text file generation"
HOMEPAGE="http://www.gnu.org/software/autogen/"
SRC_URI="mirror://gnu/${PN}/rel${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~arm-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="libopts"

RDEPEND=">=dev-scheme/guile-1.8
	dev-libs/libxml2"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libintl.patch #466462
	eautoreconf
}

src_configure() {
	# suppress possibly incorrect -R flag
	export ag_cv_test_ldflags=
	default
}

src_install() {
	default
	if ! use libopts ; then
		rm "${ED}"/usr/share/autogen/libopts-*.tar.gz || die
	fi
}
