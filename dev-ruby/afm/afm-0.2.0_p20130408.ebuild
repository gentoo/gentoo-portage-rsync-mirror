# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/afm/afm-0.2.0_p20130408.ebuild,v 1.3 2013/11/15 19:32:39 graaff Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

RUBY_FAKEGEM_VERSION="0.2.0"

inherit ruby-fakegem

DESCRIPTION="A very simple library to read Adobe Font Metrics files"
HOMEPAGE="https://github.com/halfbyte/afm"
COMMIT_ID="6765e6e7002efbdc92bc5eb6c7fee4bd25729081"
SRC_URI="https://github.com/halfbyte/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RUBY_S=${PN}-${COMMIT_ID}

ruby_add_bdepend "test? ( dev-ruby/shoulda )"

all_ruby_prepare() {
	rm Gemfile || die
}

each_ruby_test() {
	${RUBY} -Ilib -Itest test/test_afm.rb || die
}
