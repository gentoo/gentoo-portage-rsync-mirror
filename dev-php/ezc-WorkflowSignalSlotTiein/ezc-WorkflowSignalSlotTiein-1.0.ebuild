# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-WorkflowSignalSlotTiein/ezc-WorkflowSignalSlotTiein-1.0.ebuild,v 1.1 2011/12/14 22:29:07 mabi Exp $

EZC_BASE_MIN="1.8"
inherit php-ezc

DESCRIPTION="This eZ component contains the SignalSlot links for the Workflow component"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php/ezc-Workflow-1.2
	>=dev-php/ezc-SignalSlot-1.1"
