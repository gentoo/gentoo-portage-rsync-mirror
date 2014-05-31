# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-a52dec/gst-plugins-a52dec-1.2.4.ebuild,v 1.1 2014/05/31 14:17:27 pacho Exp $

EAPI="5"

inherit gst-plugins-ugly

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="+orc"

RDEPEND="
	>=media-libs/a52dec-0.7.3
	orc? ( >=dev-lang/orc-0.4.16 )
"
DEPEND="${RDEPEND}"
