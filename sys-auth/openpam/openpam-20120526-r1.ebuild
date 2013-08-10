# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/openpam/openpam-20120526-r1.ebuild,v 1.1 2013/08/10 15:59:14 aballier Exp $

EAPI="5"

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_PRUNE_LIBTOOL_FILES=all

inherit multilib autotools-multilib

DESCRIPTION="Open source PAM library."
HOMEPAGE="http://www.openpam.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE="debug vim-syntax"

RDEPEND="!sys-libs/pam"
DEPEND="sys-devel/make
	dev-lang/perl"
PDEPEND="sys-auth/pambase
	vim-syntax? ( app-vim/pam-syntax )"

PATCHES=(
	"${FILESDIR}/${PN}-20071221-gentoo.patch"
	"${FILESDIR}/${PN}-20050201-nbsd.patch"
	)

DOCS=( CREDITS HISTORY RELNOTES README )

src_prepare() {
	sed -i -e 's:-Werror::' "${S}/configure.ac"
	mkdir "${S}/m4" # Otherwise aclocal fails since ACLOCAL_AMFLAGS is set in Makefile.am

	autotools-multilib_src_prepare
}

my_configure() {
	local myeconfargs=(
		--with-modules-dir=/$(get_libdir)/security
		)
	autotools-utils_src_configure
}

src_configure() {
	multilib_parallel_foreach_abi my_configure
}
