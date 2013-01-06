# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-burn-templates/vdr-burn-templates-0.0.2.ebuild,v 1.4 2012/12/16 23:06:14 ulm Exp $

EAPI="3"

inherit eutils

DESCRIPTION="DVD-themes (background and menu) for vdr-burn"
HOMEPAGE="http://www.vdr-wiki.de/wiki/index.php/Vorlagen_(burn-plugin)"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="FDL-1.2" # only
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=media-plugins/vdr-burn-0.0.9-r2"

S="${WORKDIR}/templates"

src_install() {

	insinto /usr/share/vdr/burn
	insopts -m0644 -ovdr -gvdr
	doins "${S}"/*
}
