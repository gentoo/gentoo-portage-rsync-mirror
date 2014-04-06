# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/log_buddy/log_buddy-0.7.0.ebuild,v 1.4 2014/04/05 23:13:44 mrueg Exp $

EAPI="4"

USE_RUBY="ruby19 jruby"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.markdown examples.rb"

RUBY_FAKEGEM_EXTRAINSTALL="init.rb"

inherit ruby-fakegem eutils

DESCRIPTION="Log statements along with their name easily."
HOMEPAGE="https://github.com/relevance/log_buddy"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

ruby_add_bdepend "test? ( >=dev-ruby/mocha-0.9 )"

all_ruby_prepare() {
	rm Gemfile || die
}
