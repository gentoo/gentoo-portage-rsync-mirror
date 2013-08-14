# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/picmi/picmi-4.11.0.ebuild,v 1.1 2013/08/14 20:23:44 dilfridge Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Nonogram logic game for KDE"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="$(add_kdebase_dep libkdegames)"
RDEPEND="${DEPEND}"
