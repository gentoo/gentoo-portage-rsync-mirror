# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Scan-ClamAV/File-Scan-ClamAV-1.910.0.ebuild,v 1.1 2011/08/30 15:43:16 tove Exp $

EAPI=4

MODULE_AUTHOR=JAMTUR
MODULE_VERSION=1.91
inherit perl-module

DESCRIPTION="Connect to a local Clam Anti-Virus clamd service and send commands"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND="app-antivirus/clamav"
RDEPEND="${DEPEND}"
