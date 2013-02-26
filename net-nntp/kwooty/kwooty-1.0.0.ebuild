# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/kwooty/kwooty-1.0.0.ebuild,v 1.1 2013/02/26 08:07:32 kensington Exp $

EAPI=5
KDE_LINGUAS="cs de fr"

inherit kde4-base

DESCRIPTION="Friendly nzb linux usenet binary client"
HOMEPAGE="http://kwooty.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkworkspace)
"
RDEPEND="
	${DEPEND}
	app-arch/unrar
	app-arch/par2cmdline
"

DOCS=( README.txt TODO )
