# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-icons/kdepim-icons-4.10.3.ebuild,v 1.1 2013/05/06 20:17:48 johu Exp $

EAPI=5

KMNAME="kdepim"
KMMODULE="icons"
inherit kde4-meta

DESCRIPTION="KDE PIM icons"
IUSE=""
KEYWORDS=" ~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"

DEPEND="$(add_kdebase_dep kdepimlibs)"
RDEPEND=""
