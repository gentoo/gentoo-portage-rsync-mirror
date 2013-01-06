# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gpe-lights/gpe-lights-0.13.ebuild,v 1.2 2010/10/18 17:15:51 mr_bones_ Exp $

EAPI=2
inherit gpe

DESCRIPTION="A simple light puzzle for the GPE Palmtop Environment"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""

DEPEND="gpe-base/libgpewidget"

src_prepare() {
	gpe_src_prepare

	sed -i -e 's;include ../../base/build/Makefile.dpkg_ipkg;;' \
		   -e 's;install-program;install;g' Makefile || die "fail to sed"
}
