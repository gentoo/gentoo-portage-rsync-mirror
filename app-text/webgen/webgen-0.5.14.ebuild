# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/webgen/webgen-0.5.14.ebuild,v 1.1 2010/08/14 07:17:46 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_DOCDIR="htmldoc/rdoc"
RUBY_FAKEGEM_EXTRADOC="AUTHORS ChangeLog THANKS"
RUBY_FAKEGEM_EXTRAINSTALL="data misc"

inherit ruby-fakegem

DESCRIPTION="A template-based static website generator."
HOMEPAGE="http://webgen.rubyforge.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="builder highlight markdown"

ruby_add_bdepend "doc? ( dev-ruby/rdoc )"
ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

ruby_add_rdepend ">=dev-ruby/cmdparse-2.0.0
		>=dev-ruby/redcloth-4.1.9
		builder? ( >=dev-ruby/builder-2.1.0 )
		highlight? ( >=dev-ruby/coderay-0.8.312 )
		markdown? ( dev-ruby/maruku )"

all_ruby_prepare() {
	# Remove tests for optional dependencies that we do not have
	# packaged yet.
	rm test/test_contentprocessor_{kramdown,less,rdiscount}.rb || die
	sed -i -e '/def test_render/,/^\s*$/d' test/test_cli.rb || die

	# Add empty directory that does not get packaged by rubygems.
	# http://rubyforge.org/tracker/index.php?func=detail&aid=28393&group_id=296&atid=1207
	mkdir data/webgen/website_skeleton/src || die
}

all_ruby_install() {
	all_fakegem_install

	doman man/man1/webgen.1 || die
}
