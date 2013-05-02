# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/luabind/luabind-0.9.1.ebuild,v 1.1 2013/05/02 21:56:13 hasufell Exp $

# NOTE: cross compiling is probably broken

EAPI=5

inherit eutils multilib

DESCRIPTION="Creates bindings for lua on c++"
HOMEPAGE="http://www.rasterbar.com/products/luabind.html"
SRC_URI="mirror://sourceforge/luabind/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/lua"
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-util/boost-build"

src_prepare() {
	epatch "${FILESDIR}"/${P}-boost.patch
}

src_compile() {
	# linkflags get appended, so they actually do nothing
	bjam release \
		-d+2 \
		--prefix="${D}/usr/" \
		cflags="${CFLAGS}" \
		linkflags="${LDFLAGS}" \
		link=shared || die "compile failed"
}

src_install() {
	bjam release \
		-d+2 \
		--prefix="${D}/usr/" \
		cflags="${CFLAGS}" \
		linkflags="${LDFLAGS}" \
		link=shared \
		install || die "compile failed"

	# no idea how to fix that in Jamfile
	mv "${ED}"/usr/lib "${ED}"/usr/$(get_libdir)
}

# generally, this really sucks, patches welcome
