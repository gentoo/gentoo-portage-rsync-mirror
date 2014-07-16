# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/keditfiletype/keditfiletype-4.13.3.ebuild,v 1.1 2014/07/16 17:39:58 johu Exp $

EAPI=5

KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="KDE mime/file type assocciation editor"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

# test fails, last checked for 4.2.89
RESTRICT=test
