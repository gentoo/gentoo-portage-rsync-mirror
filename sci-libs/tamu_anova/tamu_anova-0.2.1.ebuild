# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/tamu_anova/tamu_anova-0.2.1.ebuild,v 1.4 2012/05/19 08:03:57 ago Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes

inherit autotools-utils

DESCRIPTION="ANOVA Extensions to the GNU Scientific Library"
HOMEPAGE="http://www.stat.tamu.edu/~aredd/tamuanova/"
SRC_URI="http://www.stat.tamu.edu/~aredd/tamuanova/${PN}-0.2.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-2"
IUSE="static-libs"

RDEPEND="sci-libs/gsl"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}-0.2

PATCHES=( "${FILESDIR}"/${PV}-gentoo.patch )
