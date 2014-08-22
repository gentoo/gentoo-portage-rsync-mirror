# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/uhd/uhd-3.7.2.ebuild,v 1.1 2014/08/22 16:42:29 zerochaos Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit versionator python-single-r1 cmake-utils multilib

DESCRIPTION="Universal Software Radio Peripheral (USRP) Hardware Driver"
HOMEPAGE="http://code.ettus.com/redmine/ettus/projects/uhd/wiki"

image_version=uhd-images_00$(get_version_component_range 1).00$(get_version_component_range 2).00$(get_version_component_range 3)-release
SRC_URI="https://github.com/EttusResearch/uhd/archive/release_00$(get_version_component_range 1)_00$(get_version_component_range 2)_00$(get_version_component_range 3).tar.gz -> EttusResearch-UHD-$(get_version_component_range 1).$(get_version_component_range 2).$(get_version_component_range 3).tar.gz \
	http://files.ettus.com/binaries/maint_images/archive/${image_version}.tar.gz"
#https://github.com/EttusResearch/UHD-Mirror/tags
#http://files.ettus.com/binaries/master_images/archive
KEYWORDS="~amd64 ~arm ~x86"
S="${WORKDIR}"/uhd-release_00$(get_version_component_range 1)_00$(get_version_component_range 2)_00$(get_version_component_range 3)/host

LICENSE="GPL-3"
SLOT="0/1"
IUSE=""
RDEPEND="virtual/libusb:1
	dev-libs/boost:="
DEPEND="${RDEPEND}
	dev-python/cheetah"

src_prepare() {
	#this may not be needed in 3.4.3 and above, please verify
	sed -i 's#SET(PKG_LIB_DIR ${PKG_DATA_DIR})#SET(PKG_LIB_DIR ${LIBRARY_DIR}/uhd)#g' CMakeLists.txt || die
}

src_install() {
	cmake-utils_src_install
	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}/utils/
	insinto /lib/udev/rules.d/
	doins "${S}"/utils/uhd-usrp.rules
	insinto /usr/share/${PN}
	doins -r "${WORKDIR}"/"${image_version}"/share/uhd/images
}
