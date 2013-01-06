# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-TreePersistentObjectTiein/ezc-TreePersistentObjectTiein-1.0.ebuild,v 1.1 2011/12/14 22:24:54 mabi Exp $

EZC_BASE_MIN="1.4"
inherit php-ezc

DESCRIPTION="This eZ component uses persistent objects as data storage for the
data elements of the tree nodes of the Tree component."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php/ezc-Tree-1.0
	>=dev-php/ezc-PersistentObject-1.3"
