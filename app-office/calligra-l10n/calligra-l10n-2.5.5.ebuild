# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/calligra-l10n/calligra-l10n-2.5.5.ebuild,v 1.1 2013/01/25 09:34:46 patrick Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Calligra localization package"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

DEPEND="sys-devel/gettext"
RDEPEND="!app-office/koffice-l10n"

KEYWORDS="~amd64 ~x86"
IUSE="doc"

MY_LANGS="ca da de el en_GB es et fi fr gl hu it ja kk nb nds nl pl pt pt_BR ru sk sv uk zh_CN zh_TW"
URI_BASE="mirror://kde/stable/${PN/-l10n/}-${PV}/${PN}/"
SRC_URI=""
SLOT="4"

for MY_LANG in ${MY_LANGS} ; do
	IUSE="${IUSE} linguas_${MY_LANG}"
	SRC_URI="${SRC_URI} linguas_${MY_LANG}? ( ${URI_BASE}/${PN}-${MY_LANG}-${PV}.tar.bz2 )"
done
unset MY_LANG

S="${WORKDIR}"

src_unpack() {
	local lng dir
	if [[ -z ${A} ]]; then
		elog
		elog "You either have the LINGUAS variable unset, or it only"
		elog "contains languages not supported by ${P}."
		elog "You won't have any additional language support."
		elog
		elog "${P} supports these language codes:"
		elog "${MY_LANGS}"
		elog
	fi

	[[ -n ${A} ]] && unpack ${A}
	cd "${S}"

	# add all linguas to cmake
	if [[ -n ${A} ]]; then
		for lng in ${MY_LANGS}; do
			dir="${PN}-${lng}-${PV}"
			if [[ -d "${dir}" ]] ; then
				echo "add_subdirectory( ${dir} )" >> "${S}"/CMakeLists.txt
			fi
		done
	fi
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_MESSAGES=ON -DBUILD_DATA=ON
		$(cmake-utils_use_build doc)
	)
	[[ -e "${S}"/CMakeLists.txt ]] && kde4-base_src_configure
}

src_compile() {
	[[ -e "${S}"/CMakeLists.txt ]] && kde4-base_src_compile
}

src_test() {
	[[ -e "${S}"/CMakeLists.txt ]] && kde4-base_src_test
}

src_install() {
	[[ -e "${S}"/CMakeLists.txt ]] && kde4-base_src_install
}
