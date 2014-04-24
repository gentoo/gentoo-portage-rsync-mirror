# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/state_machine/state_machine-1.2.0.ebuild,v 1.2 2014/04/24 16:42:17 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="test"
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

RUBY_FAKEGEM_EXTRAINSTALL="init.rb"

inherit ruby-fakegem

DESCRIPTION="Adds support for creating state machines for attributes on any Ruby class"
HOMEPAGE="http://www.pluginaweek.org"
IUSE="test"
SLOT="0"

LICENSE="MIT"
KEYWORDS="~amd64"

ruby_add_bdepend "test? ( dev-ruby/test-unit:2 )"

each_ruby_test() {
	ruby-ng_testrb-2 -Ilib test/{unit,functional}/*_test.rb
}
