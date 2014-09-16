# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpasswdserver/kpasswdserver-4.14.1.ebuild,v 1.1 2014/09/16 18:17:24 johu Exp $

EAPI=5

KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="KDED Password Module"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

RESTRICT="test"
# bug 393097
