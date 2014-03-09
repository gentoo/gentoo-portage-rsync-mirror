# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ofa/gst-plugins-ofa-1.2.3.ebuild,v 1.3 2014/03/09 12:08:33 pacho Exp $

EAPI="5"

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ~hppa ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="media-libs/libofa"
DEPEND="${RDEPEND}"
