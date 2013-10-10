# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-strigi-analyzer/kdepim-strigi-analyzer-4.4.11.1.ebuild,v 1.8 2013/10/10 05:26:52 creffett Exp $

EAPI=4

KMNAME="kdepim"
KMMODULE="strigi-analyzer"
inherit kde4-meta

DESCRIPTION="kdepim: strigi plugins"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-misc/strigi
	$(add_kdebase_dep kdepimlibs '' 4.6)
"
RDEPEND="${DEPEND}"
