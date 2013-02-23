# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpasswdserver/kpasswdserver-4.10.0.ebuild,v 1.2 2013/02/23 16:50:22 ago Exp $

EAPI=5

KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="KDED Password Module"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

RESTRICT="test"
# bug 393097
