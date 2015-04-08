# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gimp-lqr/gimp-lqr-0.7.2.ebuild,v 1.2 2013/11/17 23:59:41 phajdan.jr Exp $

EAPI=5

MY_P="${PN}-plugin-${PV}"

DESCRIPTION="Content-aware resizing for the GIMP"
HOMEPAGE="http://liquidrescale.wikidot.com/"
SRC_URI="http://liquidrescale.wikidot.com/local--files/en:download-page-sources/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=media-gfx/gimp-2.8
	media-libs/liblqr"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"
