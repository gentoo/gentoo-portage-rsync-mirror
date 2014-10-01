# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/sddm/sddm-0.1.0-r2.ebuild,v 1.1 2014/10/01 17:20:46 jauhien Exp $

EAPI=5
inherit cmake-utils toolchain-funcs

DESCRIPTION="Simple Desktop Display Manager"
HOMEPAGE="https://github.com/sddm/sddm"
SRC_URI="http://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm ~x86"

LICENSE="GPL-2+ MIT CC-BY-3.0 public-domain"
SLOT="0"
IUSE="consolekit systemd +upower"
REQUIRED_USE="?? ( upower systemd )"

RDEPEND="sys-libs/pam
	>=x11-base/xorg-server-1.15.1
	x11-libs/libxcb[xkb(-)]
	dev-qt/qtdeclarative:4
	dev-qt/qtdbus:4
	consolekit? ( sys-auth/consolekit )
	systemd? ( sys-apps/systemd:= )
	upower? ( || ( sys-power/upower sys-power/upower-pm-utils ) )"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-4.7.0
	virtual/pkgconfig"

pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		[[ $(gcc-version) < 4.7 ]] && \
			die 'The active compiler needs to be gcc 4.7 (or newer)'
	fi
}

src_prepare() {
	default

	epatch "${FILESDIR}/${P}-cmake.patch" "${FILESDIR}/${P}-clang.patch"
	use consolekit && epatch "${FILESDIR}/${P}-consolekit.patch"
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_use systemd)
		$(cmake-utils_use_use upower)
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	if use consolekit; then
		ewarn "This display manager doesn't have native built-in ConsoleKit support."
		ewarn "In order to use ConsoleKit pam module with this display manager,"
		ewarn "you should remove the \"nox11\" parameter from pm_ck_connector.so"
		ewarn "line in /etc/pam.d/system-login"
	fi
}
