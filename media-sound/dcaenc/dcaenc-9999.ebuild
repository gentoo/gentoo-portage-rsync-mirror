# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/dcaenc/dcaenc-9999.ebuild,v 1.1 2014/08/22 23:40:53 beandog Exp $

EAPI=5

EGIT_REPO_URI="git://gitorious.org/dtsenc/dtsenc.git"
SRC_URI=""

inherit git-r3 autotools

DESCRIPTION="DTS Coherent Acoustics audio encoder"
HOMEPAGE="http://aepatrakov.narod.ru/index/0-2"
LICENSE="LGPL-2.1+"

SLOT="0"
KEYWORDS=""
IUSE="alsa"

DEPEND="alsa? ( media-libs/alsa-lib )"

src_prepare() {
	eautoreconf
}
