# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games-extra-data/gnome-games-extra-data-2.30.0.ebuild,v 1.10 2014/02/22 21:55:57 pacho Exp $

inherit gnome2

DESCRIPTION="Optional additional graphics for gnome-games"
HOMEPAGE="http://live.gnome.org/GnomeGames/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ia64 ppc ppc64 sh sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="!<gnome-extra/gnome-games-2.24"
DOCS="AUTHORS ChangeLog NEWS README"
