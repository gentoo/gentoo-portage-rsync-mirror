# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/listen/listen-2.7.5.ebuild,v 1.3 2014/08/11 02:12:09 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Listens to file modifications and notifies you about the changes"
HOMEPAGE="https://github.com/guard/listen"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/rb-inotify-0.9.0
	>=dev-ruby/celluloid-0.15.2"
ruby_add_bdepend "test? ( dev-ruby/celluloid-io )"
# Tests take more than one hour per ruby target
RESTRICT="test"

all_ruby_prepare() {
	sed -i -e "/git/d" -e "/rb-fsevent/d" -e "/bundler/d" -e "/rspec-retry/d" ${PN}.gemspec || die
	sed -i -e "/retry/d"  spec/spec_helper.rb || die
}
