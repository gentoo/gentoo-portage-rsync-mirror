# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/prawn/prawn-0.8.4-r1.ebuild,v 1.8 2014/04/25 00:55:37 mrueg Exp $

EAPI=5
USE_RUBY="jruby ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem versionator

DESCRIPTION="Fast, Nimble PDF Generation For Ruby"
HOMEPAGE="http://prawn.majesticseacreature.com/"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

ruby_add_rdepend "=dev-ruby/prawn-core-$(get_version_component_range 1-2)*
	=dev-ruby/prawn-layout-$(get_version_component_range 1-2)*
	=dev-ruby/prawn-security-$(get_version_component_range 1-2)*"
