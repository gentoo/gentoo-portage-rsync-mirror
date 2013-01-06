# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/automoc/automoc-0.9.88.ebuild,v 1.6 2012/12/03 13:34:40 kensington Exp $

EAPI="2"

MY_PN="automoc4"
MY_P="$MY_PN-${PV}"

inherit base cmake-utils flag-o-matic

DESCRIPTION="KDE Meta Object Compiler"
HOMEPAGE="http://www.kde.org"
SRC_URI="mirror://kde/stable/${MY_PN}/${PV}/${MY_P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND="x11-libs/qt-core:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}"/${PN}-0.9.88-objc++.patch
)

src_prepare() {
	base_src_prepare

	if [[ ${ELIBC} = uclibc ]]; then
		append-flags -pthread
	fi
}
