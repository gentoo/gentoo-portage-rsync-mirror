# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/sddm/sddm-0.1.0.ebuild,v 1.2 2014/05/25 10:53:42 jauhien Exp $

EAPI=5
inherit cmake-utils toolchain-funcs

DESCRIPTION="Simple Desktop Display Manager"
HOMEPAGE="https://github.com/sddm/sddm"
SRC_URI="http://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2+ MIT CC-BY-3.0 public-domain"
SLOT="0"
IUSE="systemd +upower"
REQUIRED_USE="?? ( upower systemd )"

RDEPEND="sys-libs/pam
	x11-libs/libxcb[xkb(-)]
	dev-qt/qtdeclarative:4
	dev-qt/qtdbus:4
	systemd? ( sys-apps/systemd:= )
	upower? ( sys-power/upower:= )"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-4.7.0
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${P}-cmake.patch"
	"${FILESDIR}/${P}-clang.patch"
)

pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		[[ $(gcc-version) < 4.7 ]] && \
			die 'The active compiler needs to be gcc 4.7 (or newer)'
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_use systemd)
		$(cmake-utils_use_use upower)
	)
	cmake-utils_src_configure
}
