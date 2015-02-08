# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libixion/libixion-9999.ebuild,v 1.10 2015/02/08 18:20:40 dilfridge Exp $

EAPI=5

EGIT_REPO_URI="git://gitorious.org/ixion/ixion.git"

PYTHON_COMPAT=( python2_7 python3_3 python3_4 )

[[ ${PV} == 9999 ]] && GITECLASS="git-r3 autotools"
inherit eutils python-single-r1 ${GITECLASS}
unset GITECLASS

DESCRIPTION="General purpose formula parser & interpreter"
HOMEPAGE="http://gitorious.org/ixion/pages/Home"
[[ ${PV} == 9999 ]] || SRC_URI="http://kohei.us/files/ixion/src/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
[[ ${PV} == 9999 ]] || \
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="static-libs"

RDEPEND="${PYTHON_DEPS}
	dev-libs/boost:=
"
DEPEND="${RDEPEND}
	>=dev-util/mdds-0.12.0:=
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
	[[ ${PV} == 9999 ]] && eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static)
}

src_install() {
	default

	prune_libtool_files --all
}
