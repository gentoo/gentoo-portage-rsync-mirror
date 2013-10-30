# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/spork/spork-0.9.2-r1.ebuild,v 1.1 2013/10/30 03:44:54 mrueg Exp $

EAPI=5

USE_RUBY="ruby18 ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.rdoc"
RUBY_FAKEGEM_EXTRAINSTALL="assets"

inherit ruby-fakegem

DESCRIPTION="Spork is Tim Harper's implementation of test server."
HOMEPAGE="https://github.com/sporkrb/spork"
LICENSE="MIT"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"
IUSE=""
