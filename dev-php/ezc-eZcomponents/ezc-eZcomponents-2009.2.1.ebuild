# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-eZcomponents/ezc-eZcomponents-2009.2.1.ebuild,v 1.1 2011/12/14 22:09:42 mabi Exp $

DESCRIPTION="eZ components is an enterprise ready general purpose PHP platform."
HOMEPAGE="http://ez.no/products/ez_components"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-php/ezc-Archive-1.4.1
	>=dev-php/ezc-Authentication-1.3.1
	>=dev-php/ezc-AuthenticationDatabaseTiein-1.1
	>=dev-php/ezc-Base-1.8
	>=dev-php/ezc-Cache-1.5
	>=dev-php/ezc-Configuration-1.3.5
	>=dev-php/ezc-ConsoleTools-1.6.1
	>=dev-php/ezc-Database-1.4.7
	>=dev-php/ezc-DatabaseSchema-1.4.4
	>=dev-php/ezc-Debug-1.2.1
	>=dev-php/ezc-Document-1.3.1
	>=dev-php/ezc-EventLog-1.4
	>=dev-php/ezc-EventLogDatabaseTiein-1.0.2
	>=dev-php/ezc-Execution-1.1.1
	>=dev-php/ezc-Feed-1.3
	>=dev-php/ezc-File-1.2
	>=dev-php/ezc-Graph-1.5
	>=dev-php/ezc-GraphDatabaseTiein-1.0.1
	>=dev-php/ezc-ImageAnalysis-1.1.3
	>=dev-php/ezc-ImageConversion-1.3.8
	>=dev-php/ezc-Mail-1.7.1
	>=dev-php/ezc-MvcAuthenticationTiein-1.0
	>=dev-php/ezc-MvcFeedTiein-1.0
	>=dev-php/ezc-MvcMailTiein-1.0.1
	>=dev-php/ezc-MvcTemplateTiein-1.0
	>=dev-php/ezc-MvcTools-1.1.3
	>=dev-php/ezc-PersistentObject-1.7.1
	>=dev-php/ezc-PersistentObjectDatabaseSchemaTiein-1.3
	>=dev-php/ezc-PhpGenerator-1.0.6
	>=dev-php/ezc-Search-1.0.9
	>=dev-php/ezc-SignalSlot-1.1.1
	>=dev-php/ezc-SystemInformation-1.0.8
	>=dev-php/ezc-Template-1.4.2
	>=dev-php/ezc-TemplateTranslationTiein-1.1.1
	>=dev-php/ezc-Translation-1.3.2
	>=dev-php/ezc-TranslationCacheTiein-1.1.2
	>=dev-php/ezc-Tree-1.1.4
	>=dev-php/ezc-TreeDatabaseTiein-1.1.1
	>=dev-php/ezc-TreePersistentObjectTiein-1.0
	>=dev-php/ezc-Url-1.2.2
	>=dev-php/ezc-UserInput-1.4
	>=dev-php/ezc-Webdav-1.1.4
	>=dev-php/ezc-Workflow-1.4.1
	>=dev-php/ezc-WorkflowDatabaseTiein-1.4
	>=dev-php/ezc-WorkflowEventLogTiein-1.1
	>=dev-php/ezc-WorkflowSignalSlotTiein-1.0"
