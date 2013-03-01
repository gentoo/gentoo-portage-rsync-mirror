# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/arandr/arandr-0.1.7.ebuild,v 1.2 2013/03/01 18:13:51 jer Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} )
inherit distutils-r1

DESCRIPTION="A simple visual frontend for XRandR 1.2/1.3"
HOMEPAGE="http://christian.amsuess.com/tools/arandr/"
SRC_URI="http://christian.amsuess.com/tools/${PN}/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ARANDR_LINGUAS=(
	ar br bs ca da de el es fa fr gl hu it ja kn ko_KR lt nl pl pt_BR ro ru sk
	sv tr uk zh_CN
)

IUSE+=" ${ARANDR_LINGUAS[@]/#/linguas_}"

RDEPEND=">=dev-python/pygtk-2
	x11-apps/xrandr"
DEPEND=">=dev-python/docutils-0.6"

PYTHON_MODNAME=screenlayout

src_prepare() {
	local lingua
	for lingua in ${ARANDR_LINGUAS[@]}; do
		if ! use linguas_${lingua}; then
			rm data/po/${lingua}.po || die
		fi
	done
	distutils-r1_src_prepare
}
