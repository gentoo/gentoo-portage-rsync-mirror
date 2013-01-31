# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libexplain/libexplain-1.1.ebuild,v 1.1 2013/01/31 12:57:01 jlec Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=yes
AUTOTOOLS_IN_SOURCE_BUILD=1

inherit autotools-utils

MY_P="${P}.D001"

DESCRIPTION="Library which may be used to explain Unix and Linux system call errors"
HOMEPAGE="http://libexplain.sourceforge.net/"
SRC_URI="http://libexplain.sourceforge.net/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-3"
IUSE="static-libs"

RDEPEND="
	>=sys-kernel/linux-headers-2.6.35
	sys-libs/libcap
	>=sys-libs/glibc-2.11"
DEPEND="${DEPEND}
	app-text/ghostscript-gpl"

S=${WORKDIR}/${MY_P}

DOCS=( README )

PATCHES=(
	"${FILESDIR}"/${PN}-0.45-configure.patch
	"${FILESDIR}"/${P}-v4l2.patch
	"${FILESDIR}"/${P}-yacc.patch
)

src_prepare() {
	# Portage incompatible test
	sed \
		-e '/t0524a/d' \
		-e '/t0363a/d' \
		-i Makefile.in || die

	cp "${S}"/etc/configure.ac "${S}" || die

	autotools-utils_src_prepare
}
