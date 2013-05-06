# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-sounds/kdeartwork-sounds-4.10.3.ebuild,v 1.1 2013/05/06 20:18:34 johu Exp $

EAPI=5

RESTRICT="binchecks strip"

KMMODULE="sounds"
KMNAME="kdeartwork"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="Extra sound themes for kde"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""
