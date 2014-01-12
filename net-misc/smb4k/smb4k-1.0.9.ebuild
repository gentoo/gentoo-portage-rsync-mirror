# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/smb4k/smb4k-1.0.9.ebuild,v 1.2 2014/01/12 20:01:30 pacho Exp $

EAPI=5

KDE_LINGUAS="bg cs da de en_GB eo es et fr ga gl hu is it ja lt mai nb nds nl pl
pt pt_BR ru sk sv tr ug uk zh_CN zh_TW"
KDE_HANDBOOK="optional"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
QT_MINIMAL="4.7"
inherit kde4-base

DESCRIPTION="The advanced network neighborhood browser for KDE"
HOMEPAGE="http://sourceforge.net/projects/smb4k/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="debug"

RDEPEND=">=net-fs/samba-3.4.2[cups]"

DOCS=( AUTHORS BUGS ChangeLog README TODO )
