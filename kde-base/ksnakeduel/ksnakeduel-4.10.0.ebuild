# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksnakeduel/ksnakeduel-4.10.0.ebuild,v 1.1 2013/02/07 04:57:17 alexxy Exp $

EAPI=5

KDE_SELINUX_MODULE="games"
inherit kde4-base

DESCRIPTION="KDE Tron game"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="$(add_kdebase_dep libkdegames)"
RDEPEND="${DEPEND}"

add_blocker ktron
