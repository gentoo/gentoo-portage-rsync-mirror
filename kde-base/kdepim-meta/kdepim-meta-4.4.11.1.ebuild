# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-meta/kdepim-meta-4.4.11.1.ebuild,v 1.8 2012/12/08 12:04:14 dilfridge Exp $

EAPI=4
inherit kde4-meta-pkg

DESCRIPTION="kdepim - merge this to pull in all kdepim-derived packages"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="nls semantic-desktop"

RDEPEND="
	$(add_kdebase_dep akregator)
	$(add_kdebase_dep blogilo)
	$(add_kdebase_dep kabcclient)
	$(add_kdebase_dep kaddressbook)
	$(add_kdebase_dep kalarm)
	$(add_kdebase_dep kdepim-icons)
	$(add_kdebase_dep kdepim-kresources)
	$(add_kdebase_dep kdepim-runtime)
	$(add_kdebase_dep kdepim-strigi-analyzer)
	$(add_kdebase_dep kdepim-wizards)
	$(add_kdebase_dep kjots)
	$(add_kdebase_dep kleopatra)
	$(add_kdebase_dep kmail)
	$(add_kdebase_dep knode)
	$(add_kdebase_dep knotes)
	$(add_kdebase_dep konsolekalendar)
	$(add_kdebase_dep kontact)
	$(add_kdebase_dep korganizer)
	$(add_kdebase_dep ktimetracker)
	$(add_kdebase_dep libkdepim)
	$(add_kdebase_dep libkleo)
	$(add_kdebase_dep libkpgp)
	nls? (
		$(add_kdebase_dep kde-l10n)
		$(add_kdebase_dep kdepim-l10n)
	)
	semantic-desktop? ( $(add_kdebase_dep akonadi) )
"
