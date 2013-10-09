# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/xpath/xpath-1.0.0-r1.ebuild,v 1.1 2013/10/09 00:26:32 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem

DESCRIPTION="XPath is a Ruby DSL around a subset of XPath 1.0."
HOMEPAGE="https://github.com/jnicklas/xpath"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="1"
IUSE=""

all_ruby_prepare() {
	sed -i -e '/bundler/d' spec/spec_helper.rb || die
}
