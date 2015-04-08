# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/amazon-ec2/amazon-ec2-0.9.17-r1.ebuild,v 1.3 2014/11/03 15:38:38 mrueg Exp $

EAPI=5

USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc ChangeLog"

RUBY_FAKEGEM_BINWRAP="awshell ec2sh"

inherit ruby-fakegem

DESCRIPTION="Library for accessing the Amazon Web Services EC2 and related"
HOMEPAGE="http://github.com/grempe/amazon-ec2"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "
	test? (
		dev-ruby/test-unit:2
		>=dev-ruby/test-spec-0.10.0
		>=dev-ruby/mocha-0.9.8
		dev-ruby/yard
	)"
ruby_add_rdepend '
	>=dev-ruby/xml-simple-1.0.12
	virtual/ruby-ssl'

RUBY_PATCHES=( "${FILESDIR}"/${P}+ruby-1.9.2.patch )

all_ruby_prepare() {
	rm Gemfile || die
	sed -i -e '/[Bb]undler/d' Rakefile || die
}
