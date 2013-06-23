# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-mailbox/vdr-mailbox-0.7.0.ebuild,v 1.1 2013/06/23 19:13:16 hd_brummy Exp $

EAPI="5"

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: MailBox provides access to multiple e-mail accounts"
HOMEPAGE="http://alex.vdr-developer.org"
SRC_URI="http://alex.vdr-developer.org/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.7.41
		>=net-libs/c-client-2002e-r1"
RDEPEND="${DEPEND}"
