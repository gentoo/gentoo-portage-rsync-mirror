# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwalletmanager/kwalletmanager-4.14.3.ebuild,v 1.3 2015/02/14 14:35:04 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE Wallet Management Tool"
HOMEAGE="http://www.kde.org/applications/system/kwalletmanager
http://utils.kde.org/projects/kwalletmanager"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="!kde-base/kwallet:4"
