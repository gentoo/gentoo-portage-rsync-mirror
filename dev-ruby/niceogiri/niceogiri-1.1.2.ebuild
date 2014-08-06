# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/niceogiri/niceogiri-1.1.2.ebuild,v 1.3 2014/08/06 07:03:23 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_TASK_DOC="doc"

inherit ruby-fakegem

DESCRIPTION="Some wrappers around and helpers for XML manipulation using Nokogiri"
HOMEPAGE="https://github.com/benlangfeld/Niceogiri"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

ruby_add_rdepend "dev-ruby/nokogiri"

all_ruby_prepare() {
	sed -i -e '/guard-rspec/d' ${PN}.gemspec || die
}
