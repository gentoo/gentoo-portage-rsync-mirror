# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/vdrgraphtft-deepblue/vdrgraphtft-deepblue-0.3.1.ebuild,v 1.1 2009/10/22 14:18:28 hd_brummy Exp $

inherit eutils

MY_PN="${PN/vdrgraphtft-deepblue/DeepBlue-horchi}"

DESCRIPTION="GraphTFT theme: Deep Blue"
HOMEPAGE="http://www.vdr-wiki.de/wiki/index.php/Graphtft-plugin"
SRC_URI="http://www.jwendel.de/vdr/${MY_PN}-${PV}.tar.bz2"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		>=media-plugins/vdr-graphtft-0.3.1"

S="${WORKDIR}/DeepBlue"

src_install() {

	insinto /usr/share/vdr/graphTFT/themes/DeepBlue/
	doins -r "${S}"/*
}
