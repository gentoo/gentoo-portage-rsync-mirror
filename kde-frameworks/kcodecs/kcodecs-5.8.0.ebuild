# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/kcodecs/kcodecs-5.8.0.ebuild,v 1.1 2015/03/21 17:26:28 kensington Exp $

EAPI=5

inherit kde5

DESCRIPTION="Framework for manipulating strings using various encodings"
LICENSE="GPL-2+ LGPL-2+"
KEYWORDS=" ~amd64 ~x86"
IUSE="nls"

DEPEND="nls? ( dev-qt/linguist-tools:5 )"
